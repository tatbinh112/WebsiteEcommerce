using Antlr.Runtime;
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
            // Kiểm tra nếu Product không có giá trị Size
            if (model.Size == null || model.Size == 0)
            {
                TempData["ErrorMessage2"] = "Please select size for product.";
                return RedirectToAction("ChiTiet", "Shop", new { id = model.Product_Id }); ; // Bạn có thể thay đổi để trả về trang hiển thị sản phẩm hoặc trang phù hợp khác.
            }

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

                TempData["SuccessMessage1"] = "Product added to cart successfully!";
                return RedirectToAction("Index", "Shop");
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
                TempData["SuccessMessage1"] = "Product added to cart successfully!";
                return RedirectToAction("Index", "Shop");
            }
        }





        [HttpPost]
        public JsonResult AddToCart2(int productId)
        {

            var Customer = Session["Customer"] as User;

            int size;

            var smallestSize = db.WareHouses
                                     .Where(w => w.Product_Id == productId && w.Quantity > 0)
                                     .OrderBy(w => w.Size)
                                     .FirstOrDefault();

            if (smallestSize != null)
            {
                size = Convert.ToInt32(smallestSize.Size);
            }
            else
            {
                return Json(new { success = false, message = "There are no valid sizes in stock." });
            }



            int quantity = 1;

            if (Customer != null)
            {
                var existingCartItem = db.Carts.FirstOrDefault(c => c.User_Id == Customer.User_Id && c.Product_Id == productId && c.Size == size);
                if (existingCartItem != null)
                {
                    existingCartItem.Quantity += quantity;
                }
                else
                {
                    var cart = new Cart
                    {
                        User_Id = Customer.User_Id,
                        Product_Id = productId,
                        Size = size,
                        Quantity = quantity
                    };
                    db.Carts.Add(cart);
                }
                db.SaveChanges();
            }
            // Trường hợp người dùng chưa đăng nhập
            else
            {
                var cart = new Cart
                {
                    User_Id = null,
                    Product_Id = productId,
                    Size = size,
                    Quantity = quantity
                };
                var Carts = new List<Cart>();
                if (Session["Cart"] == null)
                {

                    Carts.Add(cart);
                    Session["Cart"] = Carts;
                }
                else
                {
                    Carts = Session["Cart"] as List<Cart>;

                    // Kiểm tra sản phẩm có tồn tại không
                    var cartItem = Carts.FirstOrDefault(c => c.Product_Id == productId && c.Size == size);
                    if (cartItem != null)
                    {
                        cartItem.Quantity += quantity;
                    }
                    else
                    {
                        Carts.Add(cart);
                    }
                    Session["Cart"] = Carts;
                }
            }

            return Json(new { success = true });
        }


        [HttpPost]
        public JsonResult UpdateQuantity(int productId, int size, int quantity)
        {
            var Customer = Session["Customer"] as User;
            if (Customer != null)
            {
                var cartItem = db.Carts.FirstOrDefault(c => c.User_Id == Customer.User_Id && c.Product_Id == productId && c.Size == size);
                if (cartItem != null)
                {
                    cartItem.Quantity = quantity;
                    db.SaveChanges();
                    return Json(new { success = true });
                }
            }
            else
            {
                var cartItems = Session["Cart"] as List<Cart>;
                if (cartItems != null)
                {
                    var cartItem = cartItems.FirstOrDefault(c => c.Product_Id == productId && c.Size == size);
                    if (cartItem != null)
                    {
                        cartItem.Quantity = quantity;
                        Session["Cart"] = cartItems;
                        return Json(new { success = true });
                    }
                }
            }
            return Json(new { success = false });
        }


        [HttpPost]
        public JsonResult RemoveFromCart(int productId, int size)
        {
            var Customer = Session["Customer"] as User;
            if (Customer != null)
            {
                var cartItem = db.Carts.FirstOrDefault(c => c.User_Id == Customer.User_Id && c.Product_Id == productId && c.Size == size);
                if (cartItem != null)
                {
                    db.Carts.Remove(cartItem);
                    db.SaveChanges();
                    return Json(new { success = true });
                }
            }
            else
            {
                var Carts = Session["Cart"] as List<Cart>;
                var cartItem = Carts.FirstOrDefault(c => c.Product_Id == productId && c.Size == size);
                if (cartItem != null)
                {
                    Carts.Remove(cartItem);
                    Session["Cart"] = Carts;
                    return Json(new { success = true });
                }
            }
            return Json(new { success = false });
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
                    TempData["Message"] = "Request to add the product to the cart.";
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
                    TempData["Message"] = "Request to add the product to the cart.";
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