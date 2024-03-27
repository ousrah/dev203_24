




    <table class="table table-bordered">
        <tr>
            <th>No</th>
            <th>Name</th>
            <th>Details</th>
            <th width="280px">Action</th>
        </tr>
        @foreach ($products as $product)
        <tr id="row{{ $product->id }}">
            <td>{{ $product->id }}</td>
            <td>{{ $product->name }}</td>
            <td>{{ $product->detail }}</td>
            <td>
            
                    <a class="btn bg-green-500 hover:bg-green-700 text-white font-bold py-1 px-2 rounded" href="{{ route('products.show',$product->id) }}">Show</a>
    
                    <a class="btn bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-2 rounded" href="{{ route('products.edit',$product->id) }}">Edit</a>
   
                
                    <button onclick="confirmDelete({{ $product->id }})" class="btn bg-red-500 hover:bg-red-700 text-white font-bold py-1 px-2 rounded">Delete</button>
           
            </td>
        </tr>
        @endforeach
    </table>
<script>
  
    function confirmDelete(id){

        $("#deleteId").val(id);
        $("#myModal").show();   
    }

   

    $(window).on("click",function(event){
        if(event.target.id==="myModal"){
            $("#myModal").hide();
        }
    })
    </script>

   