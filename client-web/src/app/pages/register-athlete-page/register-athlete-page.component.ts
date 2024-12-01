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
  selector: 'app-register-athlete-page',
  imports: [ReactiveFormsModule, RouterLink, NgIf],
  templateUrl: './register-athlete-page.component.html',
  styleUrl: './register-athlete-page.component.scss'
})
export class RegisterAthletePageComponent implements OnInit {
  registerForm!: FormGroup;

  constructor(private fb: FormBuilder) { }

  ngOnInit() {
    this.registerForm = this.fb.group({
      weight: ['', [Validators.required]],
      height: ['', [Validators.required]],
    });
  }

  get weight() {
    return this.registerForm.get('weight');
  }

  get height() {
    return this.registerForm.get('height');
  }

  onSubmit() { }
}
