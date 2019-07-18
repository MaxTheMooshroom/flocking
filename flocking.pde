//controls



ArrayList<Boid> flock;
int population = 300;
float box_size = 1000;
final PVector ORIGIN = new PVector(0,0,0);

void setup()
{
  size(800, 800, P3D);
  flock = new ArrayList<Boid>();
  for (int i = 0; i < population; i++) flock.add(new Boid());
}

float offset = 0;
PVector cameraPos = new PVector();

void draw()
{
  background(0);
  //cameraLoc.rotate()
  
  cameraPos.x = 375;
  cameraPos.y = 375;
  cameraPos.z = -box_size * 3;
  translate(375, 375, -box_size * 3);
  cameraPos.rotate(offset);
  rotateY(offset);
  
  for (Boid boid : flock)
  {
    boid.Bounds();
    boid.Flock(flock);
    boid.Update();
    boid.Draw();
  }
  stroke(255);
  noFill();
  box(box_size * 2);
  offset += 0.005;
}
