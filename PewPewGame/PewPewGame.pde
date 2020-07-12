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
final int OPTIONS = 4;
int mode = INTRO;

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
  int i = 0;
  while (i < 100) {
    objects.add(new Obstacle());
    i++;
  }
}

//##################################### DRAW ################################################

void draw() {
  println(objects.size());
  if      (mode == INTRO)    intro();
  else if (mode == GAME)     game();
  else if (mode == PAUSE)    pause();
  else if (mode == GAMEOVER) gameOver();
  else if (mode == OPTIONS) options();
  else println("Mode error!");
}

//Clicking Functions

void mouseClicked() {
  if (mode == INTRO) 
  {
    if (mouseX > 250 && mouseX < 550 && mouseY > 370 && mouseY < 430) {
      mode = GAME;
    } else if (mouseX > 250 && mouseX < 550 && mouseY > 503 && mouseY < 563) {
      mode = OPTIONS;
    } else if (mouseX > 250 && mouseX < 550 && mouseY > 637 && mouseY < 697) {
      exit();
    }
  }
  else if (mode == GAME)
  {
    if (mouseX > 39 && mouseX < 189 && mouseY > 697 && mouseY < 757) {
    mode = INTRO;
    objectDeletion();
  }
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
  
  boolean touching(GameObject obj){
    if (dist(obj.x, obj.y, x, y) < obj.size/2 + size/2) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean touchingObstacle() {
    int i = 0;
    while (i < objects.size()) {
      GameObject obj = objects.get(i);
      if (obj instanceof Obstacle && touching(obj)) {
        return true;
      }
      i++;
    }
    return false;
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
    if (isDead()) {
      mode = GAMEOVER;
      objectDeletion();
    }
  }
  
  void shoot() {
    if (mousePressed) {
      objects.add(new Bullet(x, y, 5, 1, yellow));
    }
  }
  
}

class Bullet extends GameObject {
  
  Bullet(float x, float y, float size, float hp, color c) {
    super(x, y, size, hp, c);
    if (c == yellow) {
      PVector aim = new PVector(mouseX - myPlayer.x, mouseY - myPlayer.y);
      aim.setMag(10);
      vx = aim.x;
      vy = aim.y;
    }
    if (c == white) {
      PVector aim = new PVector(myPlayer.x - x, myPlayer.y - y);
      aim.setMag(10);
      vx = aim.x;
      vy = aim.y;
    }
  }
  
  void act() {
    super.act();
    if (x < 0 || x > width || y < 0 || y > height) {hp = 0;}
    int i = 0;
    while (i < objects.size()) {
      GameObject obj = objects.get(i);
      if (obj instanceof Obstacle && touching(obj)) {
          PVector bounce = new PVector(x - obj.x, y - obj.y);
          bounce.setMag(10);
          vx = bounce.x;
          vy = bounce.y;
      }
      if (obj instanceof Enemy && touching(obj) && myColor == yellow) {
          obj.hp--;
      }
      else if (obj instanceof Player && touching(obj) && myColor == white) {
        obj.hp--;
      }
      i++;
    }
  }
  
}

class Obstacle extends GameObject {
  
  Obstacle() {
    super(purple);
  }
  
  void act() {
    super.act();
    if (touching(myPlayer)) {
      PVector bounce = new PVector(myPlayer.x - x, myPlayer.y - y);
      bounce.setMag(5);
      myPlayer.x += bounce.x;
      myPlayer.y += bounce.y;
    }
  }
  
}

class Enemy extends GameObject {
  
  int transparency;
  
  Enemy() {
    super(random(0, width), random(0, height), 20, 1, white);
    while (touchingObstacle()) {
      x = random(0, width);
      y = random(0, height);
    }
    transparency = 0;
  }
  
  void act() {
    super.act();
    if (transparency < 255) {
      transparency++;
    } else {
      objects.add(new Bullet(x, y, 5, 1, white));
    }
  }
  
  void show() {
    fill(myColor, transparency);
    ellipse(x, y, size, size);
  }
  
}

void objectDeletion() {
  int i = 0;
  while (i < objects.size()) {
    GameObject obj = objects.get(i);
    if (obj instanceof Enemy || obj instanceof Bullet) {
      objects.remove(i);
    } else {
      i++;
    }
  }
}
