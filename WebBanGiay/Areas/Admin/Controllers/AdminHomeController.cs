using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using WebBanGiay.Models;
using WebBanGiay.App_Start;

namespace WebBanGiay.Areas.Admin.Controllers
{
    public class AdminHomeController : Controller
    {
        // GET: Admin/Home
        [@Authorize(role = "0,1")]
        public ActionResult Index()
        {
            return View();
        }

        public async Task<JsonResult> GetChartData()
        {
            using (var db = new WebBanGiayEntities())
            {
                var data = await db.Products
                             .Join(db.WareHouses,
                                   p => p.Product_Id,
                                   w => w.Product_Id,
                                   (p, w) => new { p.Product_Name, w.Quantity })
                             .GroupBy(x => x.Product_Name)
                             .Select(g => new
                             {
                                 ProductName = g.Key,
                                 Quantity = g.Sum(x => x.Quantity)
                             })
                             .Take(5)
                             .ToListAsync();

                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }

        public async Task<JsonResult> GetMonthlyRevenueData()
        {
            using (var db = new WebBanGiayEntities())
            {
                var data = await db.Orders
                             .GroupBy(o => new { o.Date.Value.Year, o.Date.Value.Month })
                             .Select(g => new
                             {
                                 Month = g.Key.Month,
                                 Year = g.Key.Year,
                                 Revenue = g.Sum(o => o.OrderDetails.Sum(od => od.Quantity * od.Product.Product_Price))
                             })
                             .OrderBy(x => x.Year)
                             .ThenBy(x => x.Month)
                             .ToListAsync();

                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }

        public async Task<JsonResult> GetProductRevenueData()
        {
            using (var db = new WebBanGiayEntities())
            {
                var data = await db.OrderDetails
                             .Join(db.Products,
                                   od => od.Product_Id,
                                   p => p.Product_Id,
                                   (od, p) => new { p.Product_Name, Total = od.Quantity * p.Product_Price })
                             .GroupBy(x => x.Product_Name)
                             .Select(g => new
                             {
                                 ProductName = g.Key,
                                 Revenue = g.Sum(x => x.Total)
                             })
                             .Take(5)
                             .ToListAsync();

                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }

        public async Task<JsonResult> GetTodayRevenue()
        {
            using (var db = new WebBanGiayEntities())
            {
                var today = DateTime.Today;
                var endOfDay = today.AddDays(1).AddTicks(-1);

                var revenue = await db.Orders
                                     .Where(o => o.Date >= today && o.Date <= endOfDay)
                                     .SumAsync(o => (decimal?)o.Total_Amount) ?? 0;

                return Json(revenue, JsonRequestBehavior.AllowGet);
            }
        }


        // Lấy số đơn trong tuần
        public async Task<JsonResult> GetWeeklyOrders()
        {
            var startOfWeek = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek);
            var endOfWeek = startOfWeek.AddDays(7);

            using (var db = new WebBanGiayEntities())
            {
                var orderCount = await db.Orders
                                   .Where(o => o.Date >= startOfWeek && o.Date < endOfWeek)
                                   .CountAsync();

                return Json(orderCount, JsonRequestBehavior.AllowGet);
            }
        }

        // Lấy số sản phẩm bán ra trong tuần
        public async Task<JsonResult> GetProductsSoldInWeek()
        {
            var startOfWeek = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek);
            var endOfWeek = startOfWeek.AddDays(7);

            using (var db = new WebBanGiayEntities())
            {
                var productCount = await db.OrderDetails
                                     .Where(od => od.Order.Date >= startOfWeek && od.Order.Date < endOfWeek)
                                     .SumAsync(od => (int?)od.Quantity) ?? 0;

                return Json(productCount, JsonRequestBehavior.AllowGet);
            }
        }

        // Lấy doanh thu theo tháng
        public async Task<JsonResult> GetMonthlyRevenue()
        {
            var startOfMonth = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
            var endOfMonth = startOfMonth.AddMonths(1);

            using (var db = new WebBanGiayEntities())
            {
                var revenue = await db.Orders
                                .Where(o => o.Date >= startOfMonth && o.Date < endOfMonth)
                                .SumAsync(o => (decimal?)o.Total_Amount) ?? 0;

                return Json(revenue, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
