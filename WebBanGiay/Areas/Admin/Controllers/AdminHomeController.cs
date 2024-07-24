using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.App_Start;
using WebBanGiay.Models;

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

        public ActionResult GetChartData()
        {
            using (var db = new WebBanGiayEntities())
            {
                var data = db.Products
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
                             .ToList();

                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult GetMonthlyRevenueData()
        {
            using (var db = new WebBanGiayEntities())
            {
                var data = db.Orders
                             .GroupBy(o => new { o.Date.Value.Year, o.Date.Value.Month })
                             .Select(g => new
                             {
                                 Month = g.Key.Month,
                                 Year = g.Key.Year,
                                 Revenue = g.Sum(o => o.OrderDetails.Sum(od => od.Quantity * od.Product.Product_Price)) // Đảm bảo Product.Price có mặt trong OrderDetail
                             })
                             .OrderBy(x => x.Year)
                             .ThenBy(x => x.Month)
                             .ToList();

                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult GetProductRevenueData()
        {
            using (var db = new WebBanGiayEntities())
            {
                var data = db.OrderDetails
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
                             .ToList();

                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
