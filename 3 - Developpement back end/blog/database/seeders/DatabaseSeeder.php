<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use App\Models\Post;
use App\Models\Role;
use App\Models\User;
use App\Models\Phone;
use App\Models\Article;
use App\Models\Comment;
use Illuminate\Database\Seeder;
use Database\Factories\RoleUserFactory;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
       // Create 10 users
    User::factory(10)->create()->each(function ($user) {
          Phone::factory()->create(['user_id' => $user->id]);
          $user->roles()->attach( Role::factory()->create());
    });

       // Create 10 posts
      Post::factory(10)->create()->each(function ($post) {
           Comment::factory(10)->create(['post_id' => $post->id]);
           
        });
        Article::factory(10)->create()->each(function ($post) {
            Comment::factory(10)->create(['post_id' => $post->id]);
            
         });

      /*  \App\Models\User::factory()->create([
             'name' => 'Test User',
            'email' => 'test@example.com',
        ]);*/
    }
}
