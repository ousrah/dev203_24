<?php

namespace App\Imports;

use App\Models\User;
use App\Models\Parameter;
use Maatwebsite\Excel\Row;
use Illuminate\Support\Facades\Hash;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Events\AfterSheet;
use Maatwebsite\Excel\Concerns\OnEachRow;
use Maatwebsite\Excel\Events\BeforeSheet;
use Maatwebsite\Excel\Concerns\Importable;
use Maatwebsite\Excel\Concerns\WithEvents;
use Maatwebsite\Excel\Events\BeforeImport;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class StudentImport implements ToModel, WithHeadingRow,  WithEvents
{
    use Importable;

    protected $importStructure;

    public function __construct()
    {
        $this->importStructure = null;
    }

    public function registerEvents(): array
    {

        return [
            // Handle by a closure.
            BeforeImport::class => function(BeforeImport $event) {
                $reader = $event->getReader();
                $cellValue = $reader->getActiveSheet()->getCell('B4')->getValue();
                 if ($cellValue == "LES INFORMATIONS PERSONNELLES") {
                    $this->importStructure = 'ena';
                } elseif ($cellValue == "2") {
                    $this->importStructure = 'structure2';
                }
             }];
    }


    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */
    public function model(array $row)
    {
        if ($this->importStructure === 'ena') {
            if ($row['nom']) {

                $city_name =   trim($row['lieu_de_naissance']);
                $city = Parameter::where('name',$city_name)->first();
                if(!$city)
                {
                    $city=new Parameter();
                    $city->name=$city_name;
                    $city->name_ar=$city_name;
                    $city->parameter_type="city";
                    $city->school_id = Session("school_id");
                    $city->save();
                }

                $natinality_name =   trim($row['lieu_de_naissance']);
                $natinality = Parameter::where('name',$natinality_name)->first();
                if(!$natinality)
                {
                    $natinality=new Parameter();
                    $natinality->name=$natinality_name;
                    $natinality->name_ar=$natinality_name;
                    $natinality->parameter_type="natinality";
                    $natinality->school_id = Session("school_id");
                    $natinality->save();
                }
              //  dd($row);
                return new User([

                    'name'     => $row['prenom'] . " " . $row['nom'],
                    'name_ar'     => $row['prenom_ar'] . " " . $row['nom_ar'],
                    'first_name'    => $row['nom'],
                    'last_name'    => $row['prenom'],
                    'first_name_ar'    => $row['prenom_ar'],
                    'last_name_ar'    => $row['nom_ar'],
                    'id_msg'     => $row['prenom'] . " " . $row['nom'],
                    'password' => Hash::make($row['cin']),
                    'registration_number'    => $row['n_inscrip'],
                    'identity_number'    => $row['cin'],
                    'student_number'    => $row['cne'],
                    'birth_date'    => \PhpOffice\PhpSpreadsheet\Shared\Date::excelToDateTimeObject($row['date_de_naissance'])->format('Y-m-d'),
                    'is_student'=>1,
                    'enabled'=>1,
                    'status'=>1,
                    'status_id'=>1,
                    'school_id'=>Session("school_id"),
                    'birth_city_id'    => $city->id,
                    'remarks'    => "Année d'obtention du bac" . $row['annee_dobtention_du_bac'] . " -   Année d'accès " .$row['annee_dacces'] ." - type d'accès "  .  $row['type_dacces'],
                    'nationality_id'    => $natinality->id,
                    'sexe'    => $row['sexe'],
                    'phone'    => $row['telephone'],
                    'email'    => $row['email']
                ]);
            } else {
                return null;
            }
        } elseif ($this->importStructure === 'structure2') {
            // Importer avec la structure 2
        } else {
            // Structure non définie ou invalide, retourner null
            return null;
        }


    }

    public function headingRow(): int
    {
        return 7;
    }

}
