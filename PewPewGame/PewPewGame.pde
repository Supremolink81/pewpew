ArrayList<GameObject> objects;
Player myPlayer;

//color pallette
color black  = #000000;
color white  = #FFFFFF;
color purple = #490A3D;
color pink   = #BD1550;
color orange = #E97F02;
color yellow = #F8CA00;
color green  = #8A9B0F;

//mode framework variables
final int INTRO    = 0;
final int GAME     = 1;
final int PAUSE    = 2;
final int GAMEOVER = 3;
int mode = GAME;

//key variables;
boolean wkey, akey, skey, dkey, spacekey;


//#################################### SETUP ###############################################

void setup() {
  //graphics
  size(800, 800);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  noStroke();
  
  //initialize key variables
  myPlayer = new Player();
  objects = new ArrayList<GameObject>();
  objects.add(myPlayer);
}

//##################################### DRAW ################################################

void draw() {
  println(objects.size());
  if      (mode == INTRO)    intro();
  else if (mode == GAME)     game();
  else if (mode == PAUSE)    pause();
  else if (mode == GAMEOVER) gameOver();
  else println("Mode error!");
}

//Clicking Functions

void mouseClicked() {
  if (mode == INTRO) 
  {
    
  }
  else if (mode == GAME)
  {
    
  }
  else if (mode == PAUSE)
  {
    
  }
  else if (mode == GAMEOVER)
  {
    
  }
}

//Key Functions

void keyPressed() {
  if (key == 'w' || key == 'W') wkey = true;
  if (key == 'a' || key == 'A') akey = true;
  if (key == 's' || key == 'S') skey = true;
  if (key == 'd' || key == 'D') dkey = true;
  if (key == 'd' || key == 'D') spacekey = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') wkey = false;
  if (key == 'a' || key == 'A') akey = false;
  if (key == 's' || key == 'S') skey = false;
  if (key == 'd' || key == 'D') dkey = false;
  if (key == 'd' || key == 'D') spacekey = false;
}

//GAMEOBJECT CLASS

class GameObject {
  
  float x, y, vx, vy, size, hp;
  
  color myColor;
  
  GameObject(color c) {
    x = random(0, width);
    y = random(0, height);
    vx = 0;
    vy = 0;
    size = random(20, 100);
    hp = 1;
    myColor = c;
  }
  
  GameObject(float x, float y, float size, float hp, color c) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.hp = hp;
    this.myColor = c;
    vx = 0;
    vy = 0;
  }
  
  void act() {
    x = x + vx;
    y = y + vy;
  }
  
  void show() {
    fill(myColor);
    ellipse(x, y, size, size);
  }
  
  boolean isDead() {
    if (hp <= 0) return true;
    else return false;
  }
  
}

//PLAYER

class Player extends GameObject {
  
  Player() {
    super(width/2, height/2, 20, 1, yellow);
  }
  
  
  void act() {
    super.act();
    if (wkey) vy = -4;
    else if (akey) vx = -4;
    else if (skey) vy = 4;
    else if (dkey) vx = 4;
    if (!wkey && !skey) vy = 0;
    if (!akey && !dkey) vx = 0;
    if (x < 0) x = 0;
    if (x > width) x = width;
    if (x < 0) y = 0;
    if (y > height) y = height;
    shoot();
  }
  
  void shoot() {
    if (mousePressed) {
      objects.add(new Bullet());
    }
  }
  
}

class Bullet extends GameObject {
  
  Bullet() {
    super(myPlayer.x, myPlayer.y, 5, 1, yellow);
    vx = 0;
    vy = -10;
  }
  
  void act() {
    super.act();
    if (x < 0 || x > width || y < 0 || y > height) hp = 0;
  }
  
}
