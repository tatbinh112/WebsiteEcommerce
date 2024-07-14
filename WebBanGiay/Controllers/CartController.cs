using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.Models;

namespace WebBanGiay.Controllers
{
    public class CartController : Controller
    {
        private WebBanGiayEntities db = new WebBanGiayEntities();

        
        // GET: Cart
        public ActionResult Index()
        {

            if (Session["Customer"] == null)
            {
                return View((List<Cart>)Session["Cart"]);
            }
            else
            {
                return View(db.Carts.ToList());

            }

        }
        [HttpPost]
        public ActionResult AddToCart(Cart model)
        {
            var Customer = Session["Customer"] as User;
            // Trường hợp người dùng đã đăng nhập
            if (Customer != null)
            {
                var existingCartItem = db.Carts.FirstOrDefault(c => c.User_Id == Customer.User_Id && c.Product_Id == model.Product_Id && c.Size == model.Size);
                if (existingCartItem != null)
                {
                    existingCartItem.Quantity += model.Quantity;
                }
                else
                {
                    model.User_Id = Customer.User_Id;
                    db.Carts.Add(model);
                }
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            // Trường hợp người dùng chưa đăng nhập
            else
            {
                var Carts = new List<Cart>();
                if (Session["Cart"] == null)
                {
                    Carts.Add(model);
                    Session["Cart"] = Carts;
                }
                else
                {
                    Carts = Session["Cart"] as List<Cart>;

                    // Kiểm tra sản phẩm có tồn tại không
                    var cartItem = Carts.FirstOrDefault(c => c.Product_Id == model.Product_Id && c.Size == model.Size);
                    if (cartItem != null)
                    {
                        cartItem.Quantity += model.Quantity;
                    }
                    else
                    {
                        Carts.Add(model);
                    }
                    Session["Cart"] = Carts;
                }
                return RedirectToAction("Index");
            }
        }





    }
}