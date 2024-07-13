using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
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
    }
}