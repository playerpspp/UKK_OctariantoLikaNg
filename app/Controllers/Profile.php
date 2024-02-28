<?php

namespace App\Controllers;
use CodeIgniter\Controllers;
use App\Models\M_model;

class Profile extends BaseController
{

    protected function checkAuth()
    {
        $id_user = session()->get('id');
        $level = session()->get('level');
        if ($id_user != null) {
            return true;
        } else {
            return false;
        }
    }
    public function index()
    {
        if (!$this->checkAuth()) {
            return redirect()->to(base_url('/home/dashboard'));
        }
        
        $id=session()->get('id');
        $where2=array('id_user'=>$id);
        $model=new M_model();
        $data['data']=$model->getRow('user',$where2);

        $id=session()->get('id');
        $where=array('id_user'=>$id);

        echo view('pages/profile', $data);
    }

    public function ganti_pw()   
    {
        if (!$this->checkAuth()) {
            return redirect()->to(base_url('/home/dashboard'));
        }

        $pass=$this->request->getPost('pw');
        $id=session()->get('id');
        $model= new M_model();

        $data=array( 
            'password'=>md5($pass)
        );

        $where=array('id_user'=>$id);
        $model->edit('user', $data, $where);
        return redirect()->to('/profile');
    }

    public function ganti_profile()
    {
        if (!$this->checkAuth()) {
            return redirect()->to(base_url('/home/dashboard'));
        }
        $namaLengkap=$this->request->getPost('namaLengkap');
        $email=$this->request->getPost('email');
        $alamat=$this->request->getPost('alamat');
        $username=$this->request->getPost('username');
        $id=session()->get('id');

        $where=array('id_user'=>$id);    
       
            $user=array(
            'alamat'=>$alamat,
            'email'=>$email,
            'namaLengkap'=> $namaLengkap,
            'username'=>$username
            );
        

        $model=new M_model();
        $model->edit('user', $user,$where);

        session()->remove('username');
        session()->remove('Nama');

        session()->set('username', $username);
        session()->set('Nama', $namaLengkap);

       
        
        $log = array(
            'isi_log' => 'user mengubah data diri',
            'log_idUser' => $id,
            
        );

        $model->simpan('log', $log);
        return redirect()->to('/profile');

    }
}
