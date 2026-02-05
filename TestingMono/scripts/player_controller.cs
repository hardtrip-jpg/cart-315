using Godot;
using System;

public partial class player_controller : CharacterBody2D
{
    [Export]
    public float speed = 2;
    public double acceleration = 0.3;
    public double deceleration = 0.3;
    
    public void _PhysicsProcess(float delta)
    {
        float desiredVelocity = 0;
        base._PhysicsProcess(delta);
        if (Input.IsActionPressed("right"))
        {
            desiredVelocity += speed;
        };
        if (Input.IsActionPressed("left"))
        {
            desiredVelocity -= speed;
        }
        Velocity = new(desiredVelocity, 0);
    }
    
    
}
