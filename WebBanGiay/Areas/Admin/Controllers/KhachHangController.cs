using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.App_Start;
using WebBanGiay.Models;

namespace WebBanGiay.Areas.Admin.Controllers
{
    public class KhachHangController : Controller
    {
        // GET: Admin/KhachHang
        [@Authorize(role = "0,1")]
        public ActionResult DanhSach()
        {
            WebBanGiayEntities db = new WebBanGiayEntities();

            return View(db.Users.ToList());
        }
    }
}