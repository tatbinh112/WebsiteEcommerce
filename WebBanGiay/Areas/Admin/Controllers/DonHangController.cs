using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.App_Start;
using WebBanGiay.Models;

namespace WebBanGiay.Areas.Admin.Controllers
{
    public class DonHangController : Controller
    {
        WebBanGiayEntities db = new WebBanGiayEntities();
        // GET: Admin/DonHang
        [@Authorize(role = "0,1")]
        public ActionResult DanhSach()
        {
            return View(db.Orders.ToList());
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public JsonResult UpdateStatus(int orderId, int status)
        {
            try
            {
                var order = db.Orders.Find(orderId);
                if (order != null)
                {
                    order.Status = status;
                    db.SaveChanges();
                    return Json(new { success = true });
                }
                return Json(new { success = false, message = "Order not found" });
            }
            catch (Exception ex)
            {
                // Log exception details
                return Json(new { success = false, message = ex.Message });
            }
        }
        // GET: Admin/DonHang/ChiTiet/5
        [HttpGet]
        [@Authorize(role = "0,1")]
        public ActionResult ChiTiet(int id)
        {
            var order = db.Orders.Find(id);
            if (order == null)
            {
                return HttpNotFound();
            }

            var orderDetails = db.OrderDetails
                                 .Where(od => od.Order_Id == id)
                                 .ToList();

            ViewBag.Order = order;
            ViewBag.OrderDetails = orderDetails;

            return View();
        }

    }
}