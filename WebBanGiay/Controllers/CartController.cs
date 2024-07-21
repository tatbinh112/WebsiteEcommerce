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
            var Customer = Session["Customer"] as User;
            if (Session["Customer"] == null)
            {
                return View((List<Cart>)Session["Cart"]);
            }
            else
            {
                return View(db.Carts.Where(c => c.User_Id == Customer.User_Id).ToList());

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
        [HttpPost]
        public ActionResult UpdateCart(Cart model)
        {
            var Customer = Session["Customer"] as User;
            // Trường hợp người dùng đã đăng nhập
            if (Customer != null)
            {
                var existingCartItem = db.Carts.FirstOrDefault(c => c.Cart_Id == model.Cart_Id);
                if (existingCartItem != null)
                {
                    existingCartItem.Quantity = model.Quantity;
                    db.Carts.Add(model);
                    db.SaveChanges();

                }


                return RedirectToAction("Index");
            }
            // Trường hợp người dùng chưa đăng nhập
            else
            {
                var Carts = new List<Cart>();

                Carts = Session["Cart"] as List<Cart>;


                var cartItem = Carts.FirstOrDefault(c => c.Product_Id == model.Product_Id && c.Size == model.Size);
                if (cartItem != null)
                {
                    cartItem.Quantity = model.Quantity;
                }

                Session["Cart"] = Carts;

                return RedirectToAction("Index");
            }
        }



        public ActionResult CheckOut()
        {
            var Customer = Session["Customer"] as User;
            if (Customer == null)
            {
                var cart = Session["Cart"] as List<Cart>;
                // Kiểm tra giỏ hàng có sản phẩm không
                if (cart == null || !cart.Any())
                {
                    TempData["CartData"] = cart; // Lưu dữ liệu vào TempData
                    TempData["Message"] = "Yêu cầu thêm sản phẩm vào giỏ hàng.";
                    return RedirectToAction("Index");
                }
                else
                {
                    return RedirectToAction("Index", "Checkout");

                }
            }
            else
            {
                var cart = db.Carts.Where(c => c.User_Id == Customer.User_Id);

                if (cart == null || !cart.Any())
                {
                    TempData["Message"] = "Yêu cầu thêm sản phẩm vào giỏ hàng.";
                    return RedirectToAction("Index");
                }
                else
                {
                    return RedirectToAction("Index", "Checkout");
                }
            }
        }





    }
}