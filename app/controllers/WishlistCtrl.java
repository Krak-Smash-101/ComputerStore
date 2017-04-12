package controllers;


import play.mvc.*;
import play.api.Environment;
import play.data.*;
import play.db.ebean.Transactional;
import javax.inject.Inject;
import java.util.List;
import java.util.ArrayList;
import views.html.*;
import models.*;
import models.Basket;

public class WishlistCtrl extends Controller{

    @Transactional
    public Result addToWishlist(Long id){

        Product p = Product.find.byId(id);

        User user = getUserFromSession();

        if (user.getWishlist() == null){
            user.setWishlist(new Wishlist());
            user.getWishlist().setUser(user);
            user.update();
        }
        user.getWishlist().addProduct(p);
        user.update();

        return ok(wishlist.render(getUserFromSession()));
    }

    @Transactional
    public Result delWishlist(Long itemId) {

        // Get the order item
        OrderItem item = OrderItem.find.byId(itemId);
        // Get user
        User c = getUserFromSession();
        // Call wish-list remove item method
        c.getWishlist().removeWishItem(item);
        c.getWishlist().update();
        // back to list
        return ok(wishlist.render(c));
    }

    // Empty Wishlist
    @Transactional
    public Result emptyWishlist() {

        User c = getUserFromSession();
        c.getWishlist().removeAllItems();
        c.getWishlist().update();

        return ok(wishlist.render(c));
    }

    private User getUserFromSession() {
        return User.getUserById(session().get("email"));
    }
}
