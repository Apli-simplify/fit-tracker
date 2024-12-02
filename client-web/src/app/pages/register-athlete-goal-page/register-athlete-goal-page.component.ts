import { Component, OnInit } from '@angular/core';
import { RouterLink } from '@angular/router';

import { NgIf } from '@angular/common';
import {
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';

@Component({
  selector: 'app-register-athlete-goal-page',
  imports: [ReactiveFormsModule, RouterLink, NgIf],
  templateUrl: './register-athlete-goal-page.component.html',
  styleUrl: './register-athlete-goal-page.component.scss'
})
export class RegisterAthleteGoalPageComponent implements OnInit {
  registerForm!: FormGroup;

  constructor(private fb: FormBuilder) { }

  ngOnInit() {
    this.registerForm = this.fb.group({
      goal: ['', [Validators.required]],
    });
  }

  get goal() {
    return this.registerForm.get('goal');
  }

  onSubmit() { }
}