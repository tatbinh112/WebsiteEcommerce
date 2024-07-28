using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Drawing;
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
            if (Customer != null)
            {
                model.User_Id = Customer.User_Id;

            }
            else
            {
                model.User_Id = null;
            }

            model.Date = DateTime.Now;
            int? Total = 0;
            db.spAddOrder(model.Date, model.User_Id, Total, model.Discount_Id, model.Ship_Address, model.Ship_Email, model.Ship_PhoneNumber, model.Ship_Note, model.Ship_Name, maxidParam);

            int maxID = (int)maxidParam.Value;
            //đã đăng nhập
            if (Customer != null)
            {

                var cart = db.Carts.Where(c => c.User_Id == Customer.User_Id).ToList();
                foreach (var item in cart)
                {


                    db.spAddOrderDetail(maxID, item.Product_Id, item.Quantity, item.Size);
                    Total += item.Product.Product_Price * item.Quantity;
                    UpdateWarehouse(item.Product_Id ?? 0, item.Size ?? 0, item.Quantity ?? 0);
                };
                // Xóa tất cả sản phẩm trong giỏ hàng của người dùng sau khi thanh toán
                db.Carts.RemoveRange(cart);
            }
            else
            {


                var cart = Session["Cart"] as List<Cart>;

                foreach (var item in cart)
                {
                    int? price = 0;
                    price = db.Products.Find(item.Product_Id).Product_Price;

                    db.spAddOrderDetail(maxID, item.Product_Id, item.Quantity, item.Size);
                    Total += price * item.Quantity;
                    UpdateWarehouse(item.Product_Id ?? 0, item.Size ?? 0, item.Quantity ?? 0);

                };
                Session["Cart"] = null;
            }
            var order = db.Orders.Find(maxID) as Order;
            order.Total_Amount = Total;
            db.SaveChanges();


            return RedirectToAction("Success", new { id = maxID });

        }



        private void UpdateWarehouse(int productId, int size, int quantity)
        {
            var warehouseItem = db.WareHouses.SingleOrDefault(w => w.Product_Id == productId && w.Size == size);
            if (warehouseItem != null)
            {
                warehouseItem.Quantity -= quantity;
                db.Entry(warehouseItem).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
            }
        }

        public ActionResult Success(int id)
        {
            var order = db.Orders.Find(id);
            var detail = db.OrderDetails.Where(d => d.Order_Id == id).ToList();
            ViewBag.Detail = detail;
            return View(order);

        }

    }


}