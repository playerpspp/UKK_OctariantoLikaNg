<?= view('layout/header')?>

<?= view('layout/nav')?>

<div class="row">

    <div class="col-lg-12">
        <div class="card">
        <div class="card-title">
            <p>Selamat Datang di dashboard apa yang anda ingin dilakukan?</p>
            </div>

        <div class="card-body">
            <a href="/buku">        <button class="btn btn-primary">Daftar Buku</button></a>
            <a href="/peminjaman">  <button class="btn btn-danger">Melihat Peminjaman Buku</button></a>
             <?php  if(session()->get('level')== "peminjam"){ ?>
            <a href="/koleksi">     <button class="btn btn-warning">Melihat Koleksi Pribadi Buku</button></a>
            <?php }?>
          
            </div>
        </div>

    </div>

   







</div>


<?= view('layout/footer')?>

