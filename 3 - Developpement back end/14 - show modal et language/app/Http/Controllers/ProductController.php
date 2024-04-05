<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\View\View;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): View
    {
        $products = Product::latest()->paginate(5);
      
        return view('products.index',compact('products'))
                    ->with('i', (request()->input('page', 1) - 1) * 5);
    }


    public function search(): View
    {
        $products = Product::where('name', 'like', '%' . request('search') . '%')
        ->orWhere('detail', 'like', '%' . request('search') . '%')
        ->get();
      
        return view('products.search',compact('products'));
    }

    public function delete(Request $request)
    {
        $product = Product::find($request->deleteId);
        $product->delete();
        return "ok";
    }


    public function showModal(Request $request)
    {
       
        $product = Product::find($request->id);
     
        return view("modals.showProduct",compact('product'));
    }

/*    public function changeLocale($locale)
    {
        session()->put("locale",$locale);
        return redirect()->back();
        
    }*/

    
    public function test()
    {
        return 'ça marche';
    }
    /**
     * Show the form for creating a new resource.
     */
    public function create(): View
    {
        return view('products.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request): RedirectResponse
    {
        $request->validate([
            'name' => 'required',
            'detail' => 'required',
        ]);
      
        Product::create($request->all());
       
        return redirect()->route('products.index')
                        ->with('success','Product created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Product $product): View
    {
        return view('products.show',compact('product'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Product $product): View
    {
        return view('products.edit',compact('product'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Product $product): RedirectResponse
    {
        $request->validate([
            'name' => 'required',
            'detail' => 'required',
        ]);
      
        $product->update($request->all());
      
        return redirect()->route('products.index')
                        ->with('success','Product updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Product $product): RedirectResponse
    {
        $product->delete();
       
        return redirect()->route('products.index')
                        ->with('success','Product deleted successfully');
    }
}
