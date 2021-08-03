defmodule LvDemo.BlogsTest do
  use LvDemo.DataCase

  alias LvDemo.Blogs

  describe "blogs" do
    alias LvDemo.Blogs.Blog

    @valid_attrs %{desc: "some desc", is_published: true, name: "some name", slug: "some slug", url: "some url"}
    @update_attrs %{desc: "some updated desc", is_published: false, name: "some updated name", slug: "some updated slug", url: "some updated url"}
    @invalid_attrs %{desc: nil, is_published: nil, name: nil, slug: nil, url: nil}

    def blog_fixture(attrs \\ %{}) do
      {:ok, blog} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blogs.create_blog()

      blog
    end

    test "list_blogs/0 returns all blogs" do
      blog = blog_fixture()
      assert Blogs.list_blogs() == [blog]
    end

    test "get_blog!/1 returns the blog with given id" do
      blog = blog_fixture()
      assert Blogs.get_blog!(blog.id) == blog
    end

    test "create_blog/1 with valid data creates a blog" do
      assert {:ok, %Blog{} = blog} = Blogs.create_blog(@valid_attrs)
      assert blog.desc == "some desc"
      assert blog.is_published == true
      assert blog.name == "some name"
      assert blog.slug == "some slug"
      assert blog.url == "some url"
    end

    test "create_blog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_blog(@invalid_attrs)
    end

    test "update_blog/2 with valid data updates the blog" do
      blog = blog_fixture()
      assert {:ok, %Blog{} = blog} = Blogs.update_blog(blog, @update_attrs)
      assert blog.desc == "some updated desc"
      assert blog.is_published == false
      assert blog.name == "some updated name"
      assert blog.slug == "some updated slug"
      assert blog.url == "some updated url"
    end

    test "update_blog/2 with invalid data returns error changeset" do
      blog = blog_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_blog(blog, @invalid_attrs)
      assert blog == Blogs.get_blog!(blog.id)
    end

    test "delete_blog/1 deletes the blog" do
      blog = blog_fixture()
      assert {:ok, %Blog{}} = Blogs.delete_blog(blog)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_blog!(blog.id) end
    end

    test "change_blog/1 returns a blog changeset" do
      blog = blog_fixture()
      assert %Ecto.Changeset{} = Blogs.change_blog(blog)
    end
  end

  describe "posts" do
    alias LvDemo.Blogs.Post

    @valid_attrs %{desc: "some desc", is_published: true, slug: "some slug", title: "some title"}
    @update_attrs %{desc: "some updated desc", is_published: false, slug: "some updated slug", title: "some updated title"}
    @invalid_attrs %{desc: nil, is_published: nil, slug: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blogs.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blogs.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blogs.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blogs.create_post(@valid_attrs)
      assert post.desc == "some desc"
      assert post.is_published == true
      assert post.slug == "some slug"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Blogs.update_post(post, @update_attrs)
      assert post.desc == "some updated desc"
      assert post.is_published == false
      assert post.slug == "some updated slug"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_post(post, @invalid_attrs)
      assert post == Blogs.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blogs.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blogs.change_post(post)
    end
  end

  describe "tags" do
    alias LvDemo.Blogs.Tag

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blogs.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Blogs.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Blogs.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Blogs.create_tag(@valid_attrs)
      assert tag.title == "some title"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{} = tag} = Blogs.update_tag(tag, @update_attrs)
      assert tag.title == "some updated title"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_tag(tag, @invalid_attrs)
      assert tag == Blogs.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Blogs.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Blogs.change_tag(tag)
    end
  end
end
