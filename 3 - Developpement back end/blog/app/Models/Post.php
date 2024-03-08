<?php

namespace App\Models;

use App\Models\Comment;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Post extends Model
{
    use HasFactory;
    protected $fillable = ['title', 'description', 'image'];
    
 /**
 * Defines a relationship where a Post has many comments.
 */
public function comments()
{
    return $this->morphMany(Comment::class, 'commentable');
}


}