using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using WebBanGiay.Models;

namespace WebBanGiay.Areas.Admin.Controllers
{
    public class AdminAccountController : Controller
    {
        // GET: Admin/Account
        private WebBanGiayEntities db = new WebBanGiayEntities();
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(string user , string password)
        {
            
            var User= db.Users.SingleOrDefault(m => (m.User_Name== user ) && m.Pass_Word == password )  ;
            if (User != null)
            {
                Session["user"]= User;
                
                return Redirect("/Admin/AdminHome/Index");
            }
            else
            {
                TempData["error"] = "Tên đăng nhập hoặc mật khẩu không chính xác";
                return View();

            }
        }

        public ActionResult Logout()
        {
            Session.Remove("user");
            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }

    }
}