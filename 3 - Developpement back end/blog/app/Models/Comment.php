<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'post_id',
        'article_id',
        'comment',
    ];

//relation to user
public function user()
{
    return $this->belongsTo(User::class);
}


//relation to post
public function commentable()
{
    return $this->morphTo();
}
}
