using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.Models;

namespace WebBanGiay.Controllers
{
    public class OrderController : Controller
    {
        private WebBanGiayEntities db = new WebBanGiayEntities();
        // GET: Order
        public ActionResult Index()
        {
            var customer = Session["Customer"] as User;
            if (customer == null)
            {
                return RedirectToAction("Login", "Account");
            }

            var orders = db.Orders.Where(o => o.User_Id == customer.User_Id).ToList();
            return View(orders);
        }

        // GET: DonHang/Details/5
        public ActionResult Details(int id)
        {
            var customer = Session["Customer"] as User;
            if (customer == null)
            {
                return RedirectToAction("Login", "Account");
            }

            var order = db.Orders.FirstOrDefault(o => o.Order_Id == id && o.User_Id == customer.User_Id);
            if (order == null)
            {
                return HttpNotFound();
            }

            var orderDetails = db.OrderDetails.Where(od => od.Order_Id == id).ToList();
            ViewBag.Order = order;
            ViewBag.OrderDetails = orderDetails;

            return View();
        }


    }
}