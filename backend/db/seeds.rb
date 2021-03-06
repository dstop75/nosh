# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([
  {
    email: "katelyn@heelheathcote.com",
     first_name: "Creola",
     last_name: "Cummings",
     # password: "autem",
     password_digest: "$2a$10$5e.hnel2jFHrgm3f1bjjNuhJ46Svf2EpzHMkQsUCslvpFrxD56tk2",
     token: "8tmgt4enhr2bcaoahcpuc7sd18xt1cdc",
     admin: true
    },
    {
      email: "margarette_raynor@johnsklein.info",
      first_name: "Delaney",
      last_name: "Ernser",
      # password: "error",
      password_digest: "$2a$10$Gu3CLPH1GnGhkAQL5m8BBu3RzfRCJvueosaEnIt4n3nDfDFM4XoKS",
      token: "2xtu187ymywgcoye3m772sfotkwef4dk",
      admin: false
      },
      {
        email: "michale.kshlerin@sawaynwindler.name",
        first_name: "Ulices",
        last_name: "Walsh",
        # password: "asperiores",
        password_digest: "$2a$10$kBJ62/zxa8HWwsV/.yAgFexBk8JkqLRzbW5DpydxZ4irm9TDwvsqu",
        token: "hqjb423sqc09n6f5pd47ah7f044b70ou",
        admin: false
        }])

products = Product.create([
  {
    name: "Basic",
    description: "Hand painted sugar cookies - \nStandard size - \nOne dozen",
    price: 30.00,
    image_url: "https://s3.amazonaws.com/nosh-cookie-co/nosh-square/052.jpg"
    },
    {
      name: "Detailed",
      description: "Hand painted sugar cookies - \nStandard size - \nOne dozen",
      price: 36.00,
      image_url: "https://s3.amazonaws.com/nosh-cookie-co/nosh-square/065.jpg"
      },
      {
        name: "Custom",
        description: "Hand painted sugar cookies - \nLarger size - \nOne dozen",
        price: 36.00,
        image_url: "https://s3.amazonaws.com/nosh-cookie-co/nosh-square/073.jpg"
        },
        {
          name: "Photographically printed",
          description: "Simple dipped sugar trim - \nPrice per cookie",
          price: 2.00
          },
          {
            name: "Photographically printed",
            description: "Hand piped trim and detail - \nPrice per cookie",
            price: 3.00
            },
            {
              name: "Individual bagging",
              description: "With matching ribbon - \nPrice per dozen",
              price: 5.00
              }])
