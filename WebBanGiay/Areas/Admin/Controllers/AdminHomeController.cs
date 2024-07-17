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
        [@Authorize(role ="0,1")]
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
                             .Take(5) // Lấy 5 sản phẩm đầu tiên
                             .ToList();

                return Json(data, JsonRequestBehavior.AllowGet);
            }
        }


    }
}