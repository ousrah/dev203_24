<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Post;


class PostController extends Controller
{
    
    /**
     * A description of the entire PHP function.
     *
     * @return View
     */
    public function index() {
        $posts = Post::orderBy('created_at', 'desc')->get();
        return view('posts.index', ['posts' => $posts]);
      }
          
      // Create post
      public function create() {
        return view('posts.create');
      }

      /**
       * Calculates the factorial of a number.
       *
       * @param int $number the number to calculate the factorial for
       * @param int $result the current result of the factorial calculation
       * @return int the factorial of the given number
       */
      public function factorial($number, $result = 1) {
        if ($number <= 1) {
          return $result;
        }

        return $this->factorial($number - 1, $number * $result);
      }



//write a edit function of post model
      public function update($id) {
        $post = Post::find($id);
        return view('posts.update', ['post' => $post]);
      }


      
      /**
       * Store a newly updated resource in storage.
       *
       * @param Request $request
       * @return Redirect
       */
      public function storeUpdate(Request $request) {
        // validations
        $request->validate([
          'title' => 'required',
          'description' => 'required',
        ]);
        
        $post = Post::find($request->id);
        $post->title = $request->title;
        $post->description = $request->description;
        $post->save();

        return redirect()->route('posts.index')->with('success', 'Post updated successfully.');
      }

      /**
       
       * Store a newly created resource in storage.
       *
       * @param Request $request
       * @throws Some_Exception_Class description of exception
       * @return Some_Return_Value
       */
      public function store(Request $request) {
        // validations
        $request->validate([
          'title' => 'required',
          'description' => 'required',
          'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);
      
        $post = new Post;
      
        $file_name = time() . '.' . request()->image->getClientOriginalExtension();
        request()->image->move(public_path('images'), $file_name);
      
        $post->title = $request->title;
        $post->description = $request->description;
        $post->image = $file_name;
      
        $post->save();
        return redirect()->route('posts.index')->with('success', 'Post created successfully.');
      }
      
}
