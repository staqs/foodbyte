class Mutations {
  static String getfoods = ''' 
  query{
  allProducts{
    id
    name
    price
    image
    description
    category{
      name
    }
  }
}
  ''';

  static String addItemToOrder = r'''
    mutation addOrder($price : Float!, $itemId:String!, $quantity : Int!, $customer : String!){
		createOrder(data : {price:$price, itemId: $itemId, quantity : $quantity, customer : $customer}){
    itemId
  }
}
''';

  static String allRestaurants = r'''
 query{

  allRestaurants{
    name
    image
    status 
    location
    longitude
    latitude
    foods{
       name
      image
      price
      description
      id
       category{
        name
      }
    }
  }
}
''';

  static String allCategories = r'''
 query{

allCategories{
  name
  image
}
  
}
''';
}
