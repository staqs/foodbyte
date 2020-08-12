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
    mutation addOrder($price : Float!, $food:ProductRelateToOneInput!, $quantity : Int!, $customer : CustomerRelateToOneInput!, $res : RestaurantRelateToOneInput!){
		createOrder(data : {price:$price, food: $food, quantity : $quantity, customer : $customer,  restaurant : $res}){
    id
  }
}
''';

  static String allRestaurants = r'''
 query{

  allRestaurants{
    id
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

  static String login = r'''
query getCustomer($email : String!, $password : String!){
  allCustomers(where : {email : $email, password : $password}){
    name
    email
    id
    password
  }
}

''';

  static String signup = r'''
mutation($username : String!, $email : String!, $password : String!){
   createCustomer(data : {name : $username, email :$email, password:$password}){
    name
    password
    email
    id
  }

}

''';

  static String allCategories = r'''
 query{

allCategories{
  name
  image
  id
}
  
}
''';
}
