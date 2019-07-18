class Boid
{
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector colour;
  float perception = box_size / 6;
  float maxForce;
  float maxSpeed;
  float size;
  float cameraDist = 0;
  
  Boid()
  {
    size = 0;
    position = new PVector(random(-box_size, box_size), random(-box_size, box_size), random(-box_size, box_size));
    velocity = PVector.random3D();
    acceleration = new PVector();
    colour = new PVector(random(255), random(255), random(255));
    maxForce = 0.2;
    maxSpeed = box_size / 100;
    
    velocity.setMag(random(2,4));
  }
  
  PVector Align(ArrayList<Boid> boids)
  {
    PVector average = new PVector();
    int total = 0;
    for (Boid boid : boids)
    {
      if (dist(this.position.x, this.position.y, this.position.z, boid.position.x, boid.position.y, boid.position.z) <= perception
          && boid != this) 
      {
        average.add(boid.velocity);
        total++;
      }
    }
    
    if (total > 0) 
    {
      average.div(boids.size());
      average.setMag(maxSpeed);
      average.sub(this.velocity);
      average.limit(maxForce);
    }
    
    return average;
  }
  
  PVector Cohesion(ArrayList<Boid> boids)
  {
    PVector average = new PVector();
    int total = 0;
    for (Boid boid : boids)
    {
      if (dist(this.position.x, this.position.y, this.position.z, boid.position.x, boid.position.y, boid.position.z) <= perception
          && boid != this) 
          {
              average.add(boid.position);
              total++;
          }
    }
    
    if (total > 0) 
    {
      average.div(boids.size());
      average.sub(this.position);
      average.setMag(maxSpeed);
      average.sub(this.velocity);
      average.limit(maxForce);
    }
    
    return average;
  }
  
  PVector Seperation(ArrayList<Boid> boids)
  {
    PVector average = new PVector();
    int total = 0;
    for (Boid boid : boids)
    {
      float distance = dist(this.position.x, this.position.y, this.position.z, boid.position.x, boid.position.y, boid.position.z);
      if (distance <= perception
          && boid != this) 
          {
            PVector difference = PVector.sub(this.position, boid.position);
            difference.div(distance);
            average.add(difference);
            total++;
          }
    }
    
    if (total > 0) 
    {
      average.div(boids.size());
      average.setMag(maxSpeed);
      average.sub(this.velocity);
      average.limit(maxForce);
    }
    
    return average;
  }
  
  void Bounds()
  {
    if (this.position.x > box_size) 
    {
      this.position.x = -box_size;
    } else if (this.position.x < -box_size) 
    {
      this.position.x = box_size;
    }
    
    if (this.position.y > box_size) 
    {
      this.position.y = -box_size;
    } else if (this.position.y < -box_size) 
    {
      this.position.y = box_size;
    }
    
    if (this.position.z > box_size) 
    {
      this.position.z = -box_size;
    } else if (this.position.z < -box_size) 
    {
      this.position.z = box_size;
    }
  }
  
  void Flock(ArrayList<Boid> boids)
  {
    acceleration.set(0, 0, 0);
    PVector alignment = Align(boids);
    PVector cohesion = Cohesion(boids);
    PVector seperation = Seperation(boids);
    acceleration.add(alignment);
    acceleration.add(cohesion);
    acceleration.add(seperation);
    acceleration.limit(maxSpeed);
  }
  
  void Update()
  {
    this.position.add(this.velocity);
    this.velocity.add(this.acceleration);
  }
  
  void Draw()
  {
    cameraDist = dist(position.x, position.y, position.z, cameraPos.x, cameraPos.y, cameraPos.z);
    size = map(cameraDist, 0, box_size * 3, 1, 6); 
    
    strokeWeight(size);
    stroke(colour.x, colour.y, colour.z);
    point(position.x, position.y, position.z);
    strokeWeight(1);
  }
}
