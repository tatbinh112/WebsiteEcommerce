using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.App_Start;

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
    }
}