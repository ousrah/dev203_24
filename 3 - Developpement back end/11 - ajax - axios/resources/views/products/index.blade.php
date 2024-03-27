@extends('products.layout')
 
@section('content')


<div class='max-w-md mx-auto'>
    <div class="relative flex items-center w-full h-12 rounded-lg focus-within:shadow-lg bg-white overflow-hidden">
        <div class="grid place-items-center h-full w-12 text-gray-300">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
        </div>
<form id="searchForm" onsubmit="return submitForm(event)" action="{{ route('products.search') }}" method="post">
    @csrf
 <input
        class="peer h-full w-full outline-none text-sm text-gray-700 pr-2"
        type="text"
        id="search" name="search"
        placeholder="Search something.." /> 

</form>

       
    </div>
</div>


    <div class="row">
        <div class="col-lg-12 margin-tb">
            <div class="pull-left">
                <h2>Laravel 10 CRUD Example from scratch - ItSolutionStuff.com</h2>
            </div>
            <div class="pull-right">
                <a class="btn btn-success" href="{{ route('products.create') }}"> Create New Product</a>
            </div>
        </div>
    </div>
   
    @if ($message = Session::get('success'))
        <div class="alert alert-success">
            <p>{{ $message }}</p>
        </div>
    @endif
   
    <div id="searchResult">
        @include('products.search')
        {!! $products->links() !!} 
    </div>
  
  
@include('modals.deleteProduct')
      
@endsection
@section("scripts")
<script>
    
    function submitForm(event){
            event.preventDefault();
            var formData = $('#searchForm').serialize();
       //     alert(formData);
            $.ajax({
                type:'POST',
                url:$('#searchForm').attr("action"),
                data: formData,
                success: function(data){
                    $('#searchResult').html(data);
                    },
                error: function(xhr,status,error){
                    console.error(xhr.responseText);
                }
            })

        }

</script>
@endsection