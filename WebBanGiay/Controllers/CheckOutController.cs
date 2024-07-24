using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.EnterpriseServices.CompensatingResourceManager;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.Models;

namespace WebBanGiay.Controllers
{
    public class CheckOutController : Controller
    {
        private WebBanGiayEntities db = new WebBanGiayEntities();

        private vietnamese_administrative_unitsEntities vn = new vietnamese_administrative_unitsEntities();

        // GET: CheckOut
        public ActionResult Index()
        {
            var Customer = Session["Customer"] as User;
            if (Customer == null)
            {
                var cart = Session["Cart"] as List<Cart>;
                // Kiểm tra giỏ hàng có sản phẩm không
                if (cart == null || !cart.Any())
                {

                    return RedirectToAction("CheckOut", "Cart");
                }
                else
                {
                    return View((List<Cart>)Session["Cart"]);
                }
            }
            else
            {
                var cart = db.Carts.Where(c => c.User_Id == Customer.User_Id).ToList();
                // Kiểm tra giỏ hàng có sản phẩm không
                if (cart == null || !cart.Any())
                {

                    return RedirectToAction("CheckOut", "Cart");
                }
                else
                {
                    return View(cart);
                }
            }
            return View();

        }
        public JsonResult GetDistricts(string province_code)
        {
            vn.Configuration.ProxyCreationEnabled = false;
            var districts = vn.districts.Where(d => d.province_code == province_code).ToList();
            return Json(districts, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetWards(string district_code)
        {
            vn.Configuration.ProxyCreationEnabled = false;
            var wards = vn.wards.Where(w => w.district_code == district_code).ToList();
            return Json(wards, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Payment(Order model)
        {
            ObjectParameter maxidParam = new ObjectParameter("maxid", typeof(int));
            var Customer = Session["Customer"] as User;
            model.User_Id = Customer.User_Id;
            model.Date = DateTime.Now;

            db.spAddOrder(model.Date, model.User_Id, model.Total_Amount, model.Discount_Id, model.Ship_Address, model.Ship_Email, model.Ship_PhoneNumber, model.Ship_Note, model.Ship_Name, maxidParam);
            int maxID = (int)maxidParam.Value;
            if (Customer != null)
            {

                var cart = db.Carts.Where(c => c.User_Id == Customer.User_Id).ToList();
                db.Orders.Add(model);
                foreach (var item in cart)
                {
                    db.spAddOrderDetail(maxID, item.Product_Id, item.Quantity, item.Size);

                };
            }
            else
            {


                var cartItem = Session["Cart"] as List<Cart>;
                var cart = cartItem.Where(c => c.User_Id == Customer.User_Id);
                foreach (var item in cart)
                {


                    db.spAddOrderDetail(maxID, item.Product_Id, item.Quantity, item.Size);


                };
            }
            return RedirectToAction("index", "Shop");

        }
    }


}