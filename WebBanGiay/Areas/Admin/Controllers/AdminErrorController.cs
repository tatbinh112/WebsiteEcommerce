using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebBanGiay.Areas.Admin.Controllers
{
    public class AdminErrorController : Controller
    {
        // GET: Admin/AdminError
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult KhongCoQuyen()
        { 
            return View();
        }
    }
}