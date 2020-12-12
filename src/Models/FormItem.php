<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FormItem extends Model
{
    protected $table = 'form_items';
    protected $guarded = ['id', 'created_at', 'updated_at'];

    public const ITEM_TYPE = ['テキスト', 'テキストエリア', '電話番号', 'Eメール', 'パスワード', 'セレクトボックス', 'ラジオボタン', 'チェックボックス', '日付'];
    public const VALIDATE_TYPE = [
        '' => 'なし',
        '[ァ-ヴー\s　]+' => 'フリガナ',
        '[\w\d._%+-]+@[\w\d._-]+\.[\w\d._-]+' => 'Eメール',
        '^\d{10}$|^\d{11}$' => '電話番号（ハイフンなし）',
        '^\d{3,4}-\d{3,4}-\d{4}$' => '電話番号（ハイフンあり）',
        '^\d{10}$|^\d{11}$|^\d{3,4}-\d{3,4}-\d{4}$' => '電話番号（ハイフンあり・なし両方）',
        '^\d{3}$|^\d{5}$|^\d{7}$' => '郵便番号（ハイフンなし）',
        '^\d{3}[-]\d{4}$|^\d{3}[-]\d{2}$|^\d{3}$' => '郵便番号（ハイフンあり）',
        '^\d{3}[-]\d{4}$|^\d{3}[-]\d{2}$|^\d{3}$|^\d{5}$|^\d{7}$' => '郵便番号（ハイフンあり・なし両方）',
        '^[0-9]+$' => '全て数値（半角）',
        '^[0-9０-９]+$' => '全て数値（全角,半角）'
    ];

    public function group() {
        return $this->belongsTo('App\Models\FormGroup');
    }
}
