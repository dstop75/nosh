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
    name: "Product 1",
    description: "The first product",
    price: 14.99,
    image_url: "https://s3.amazonaws.com/nosh-cookie-co/nosh-photos-by-john-caplice/001.jpg"
    },
    {
      name: "Product 2",
      description: "The second product",
      price: 4.99,
      image_url: "https://s3.amazonaws.com/nosh-cookie-co/nosh-photos-by-john-caplice/027.jpg"
      },
      {
        name: "Product 3",
        description: "The third product",
        price: 10.99,
        image_url: "https://s3.amazonaws.com/nosh-cookie-co/nosh-photos-by-john-caplice/074.jpg"
        },
        {
          name: "Product 4",
          description: "The fourth product",
          price: 10.99,
          image_url: "https://s3.amazonaws.com/nosh-cookie-co/nosh-photos-by-john-caplice/081.jpg"
          }])
