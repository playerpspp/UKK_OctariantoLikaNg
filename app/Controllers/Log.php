<?php

namespace App\Controllers;

use App\Models\M_model;

class Log extends BaseController
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
        $model= new M_model();
        $on='log.log_idUser=user.id_user';
        if(session()->get('level')!= "peminjam"){
           
            $data['data']= $model->fusionDESC('log','user',$on);
            }else{
                $data['data']=$model->fusion_wDESC('log','user',$on, ['log.log_idUser' => session()->get('id')]);
            }
       

        echo view('pages/log',$data);
    }

}