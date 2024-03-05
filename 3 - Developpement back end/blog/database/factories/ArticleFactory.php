<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use GuzzleHttp\Client;
/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\article>
 */
class ArticleFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {

    
// Utilisez Guzzle pour effectuer une requête GET
       $client = new Client();
        $response = $client->get('https://api.thecatapi.com/v1/images/search', ['verify' => false]);
              // Vérifiez si la requête a réussi
              if ($response->getStatusCode() == 200) {
                $imageData = json_decode($response->getBody()->getContents(), true);

                return [
                    'title' => fake()->sentence(),
                    'description' => fake()->paragraph(5),
                    'image' => $imageData[0]['url'],
                ];
            } else {
            // Gérez le cas où la requête échoue
            return [
                'title' => fake()->sentence(),
                'description' =>  fake()->paragraph(5),
                'image' => fake()->imageUrl(640, 480, 'cats'), // Fallback à une image aléatoire
            ];
       }
    }
}
