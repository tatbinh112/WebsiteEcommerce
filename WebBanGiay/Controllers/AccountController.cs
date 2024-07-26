using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using WebBanGiay.Models;

namespace WebBanGiay.Controllers
{
    public class AccountController : Controller
    {
        // GET: Account
        private WebBanGiayEntities db = new WebBanGiayEntities();
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(string user, string password)
        {
            var Customer = db.Users.SingleOrDefault(m => (m.User_Name == user) && m.Pass_Word == password);
            if (Customer != null)
            {
                Session["Customer"] = Customer;

                return Redirect("/Home/Index");
            }
            else
            {
                TempData["error"] = "Tên đăng nhập hoặc mật khẩu không chính xác";
                return View();

            }
        }
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Create(User model)
        {
            bool check = true;
            int username = db.Users.Count(u => u.User_Name == model.User_Name);
            if (username > 0)
            {
                check = false;
                TempData["user"] = "Tên đăng nhập đã tồn tại";
            }
            int sdt = db.Users.Count(u => u.Phone_Number == model.Phone_Number);
            if (sdt > 0)
            {
                check = false;
                TempData["phone"] = "Số điện thoại đã tồn tại";
            }
            int mail = db.Users.Count(u => u.Email == model.Email);
            if (mail > 0)
            {
                check = false;
                TempData["email"] = "Email đã tồn tại";
            }

            if (check)
            {
                db.Users.Add(model);
            }

            else { return View(model); }
            return View();
        }

        public ActionResult Logout()
        {
            Session.Remove("Customer");
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }
        public ActionResult ProfileCustomer()
        {
            return View();
        }
    }
}