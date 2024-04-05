



<div id="myModalShowProduct" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <span class=" btnCloseShow close">&times;</span>
      <h2>Show</h2>
    </div>
    <div class="modal-body">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12">
            <div class="form-group">
                <strong>Name:</strong>
                {{ $product->name }}
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-12">
            <div class="form-group">
                <strong>Details:</strong>
                {{ $product->detail }}
            </div>
        </div>
    </div>
   
    </div>
    <div class="modal-footer">
      <button  class="btnCloseShow btn bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded" id="close">Close</button>
    </div>
  </div>

</div>
<script>
     $(".btnCloseShow").on('click',function(){
        $("#myModalShowProduct").hide();
    })
    
   
    </script>