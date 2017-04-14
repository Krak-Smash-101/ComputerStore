package models;

import com.avaje.ebean.Model;
import javax.persistence.*;
import java.util.Iterator;
import java.util.List;


@Entity
public class Wishlist extends Model {

    @Id
    private Long id;

    @OneToMany(mappedBy = "wishlist", cascade = CascadeType.PERSIST)
    private List<OrderItem> wishItems;

    @OneToOne
    private User user;

    // Default constructor
    public Wishlist() {
    }

    // Add product to wish-list
    // Either update existing order item or ad a new one.
    public void addProduct(Product p) {

        boolean itemFound = false;

        for (OrderItem i : wishItems) {
            if (i.getProduct().getProductId() == p.getProductId()) {
                i.increaseQty();
                itemFound = true;
                break;
            }
        }
        if (itemFound == false) {
            // Add orderItem to list
            OrderItem newItem = new OrderItem(p);
            // Add to items
            wishItems.add(newItem);
        }
    }

    //Maybe I don't need this method??
    public void removeWishItem(OrderItem item) {
        for (Iterator<OrderItem> itr = wishItems.iterator(); itr.hasNext();) {
            OrderItem i = itr.next();
            if (i.getId().equals(item.getId()))
            {
                // Don't need quantity logic??
                if (i.getQuantity() > 1 ) {
                    i.minusQty();
                }
                else{
                // delete object from db
                item.delete();
                // remove object from list
                itr.remove();
                break;
                }
            }
        }
    }

    public void removeAllItems() {
        for(OrderItem i: this.wishItems) {
            i.delete();
        }
        this.wishItems = null;
    }

    //Generic query helper
    public static Finder<Long,Wishlist> find = new Finder<Long,Wishlist>(Wishlist.class);

    //Find all Products in the database
    public static List<Wishlist> findAll() {
        return Wishlist.find.all();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public List<OrderItem> getWishItems() {
        return wishItems;
    }

    public void setWishItems(List<OrderItem> wishItems) {
        this.wishItems = wishItems;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}

/* "jdbc:h2:file:./data/ComputerStore" */