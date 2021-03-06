# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LvDemo.Repo.insert!(%LvDemo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LvDemo.Repo
alias LvDemo.Blogs.Blog
alias LvDemo.Blogs.Post
alias LvDemo.Blogs.Tag

Repo.delete_all(Tag)
Repo.delete_all(Post)
Repo.delete_all(Blog)


{:ok, elixir} = Repo.insert(%Tag{title: "Elixir"})
{:ok, phoenix} =Repo.insert(%Tag{title: "Phoenix"})


Repo.insert!(%Blog{
  name: "Elixir Blog",
  slug: "elixr",
  desc: "An Elixir blog",
  url: "/elixir",
  is_published: true,
  posts: [
    %Post{title: "Hello World", slug: "hello-world", desc: "Welcome post", is_published: true,
      body: "Post goes here....",
      tags: [elixir, phoenix]

    },
    %Post{title: "My Learning", slug: "learning", desc: "Today I learnt...", is_published: true,
      body: "Post goes here...."},
  ]
})
