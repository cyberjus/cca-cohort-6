public class ProductIntegration {
  // https://fakestoreapi.com/docs

  @future(callout=true)
  public static void syncNewProducts(Set<Id> productIds) {
    for (Id id : productIds) {
      syncProduct(id);
    }
  }

  public static void syncProduct(Id productId) {
    Http http = new Http();

    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://fakestoreapi.com/products');
    request.setMethod('POST');

    Product2 productSObject = [
      SELECT Id, Name, Description, Family, ExternalId
      FROM Product2
      WHERE Id = :productId
    ];

    Product product = new Product();
    product.title = productSObject.Name;
    product.description = productSObject.Description;
    product.category = productSObject.Family;

    request.setBody(JSON.serialize(product));

    HttpResponse response = http.send(request);

    if (response.getStatus() == 'OK') {
      System.debug(response.getBody());

      Product responseProduct = (Product) JSON.deserialize(
        response.getBody(),
        Product.class
      );
      System.debug(responseProduct);

      Product2 updateProduct = new Product2(
        Id = productId,
        ExternalId = responseProduct.Id
      );
      update updateProduct;
    }
  }

  // https://fakestoreapi.com/docs#p-new
  public class Product {
    public String title;
    public Decimal price;
    public String description;
    public String image;
    public String category;
    public String id;

    public Product() {
    }
  }
}
