<?= view('layout/header')?>

<?= view('layout/nav')?>

<div class="row">

    <div class="col-lg-12">
        <div class="card">
        <div class="card-title">
            <p>Tabel Pengawai</p>
            </div>

        <div class="card-body">
        <a href="<?= base_url('/peminjam/input_pengawai')?>"> <button type="button" class="btn btn-success" >
										Tambah Peminjam
									</button> </a>
        <table id="bootstrap-data-table" class="table table-striped table-bordered">					<thead>
						<tr>
							<th style="text-align: center;" width="1000px">No.</th>
							<th style="text-align: center;" width="1000px">Nama Lengkap</th>
							<th style="text-align: center;" width="1000px">Log</th>
							<th style="text-align: center;" width="1000px">Tanggal dan Waktu</th>
						
						</tr>
					</thead>
					<tbody>
					<?php
                    $no=1;
                    foreach ($data as $dataa){?>
						<tr>
							<td style="text-align: center;" class="text-capitalize"><?php echo $no++ ?></td>
							<td style="text-align: center;" class="text-capitalize"><?php echo $dataa->namaLengkap ?></td>
							<td style="text-align: center;" class="text-capitalize"><?php echo $dataa->isi_log ?></td>
							<td style="text-align: center;" class="text-capitalize"><?php echo $dataa->tanggal_log ?></td>
							
							
                            </td>

                           
							
						</tr>
                    <?php }?>
					</tbody>
				</table>
          
            </div>
        </div>

    </div>

   







</div>


<?= view('layout/footer')?>

