import { Component, OnInit } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { NgIf, JsonPipe } from '@angular/common';
import {
  FormBuilder,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { CustomValidators } from '../../utils/custom-validator';
import { AuthService } from '../../services/auth/auth.service';

@Component({
  selector: 'app-register-page',
  standalone: true,
  imports: [ReactiveFormsModule, RouterLink, NgIf],
  templateUrl: './register-page.component.html',
  styleUrl: './register-page.component.css',
})
export class RegisterPageComponent implements OnInit {
  registerForm!: FormGroup;

  constructor(private fb: FormBuilder, private authService: AuthService, private router: Router) { }

  ngOnInit() {
    this.registerForm = this.fb.group({
      name: ['', [Validators.required]],
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, CustomValidators.passwordStrength()]],
      age: ['', [Validators.required]],
      role: ['', [Validators.required]],
      gender: ['', [Validators.required]],
    });
  }

  get name() {
    return this.registerForm.get('name');
  }

  get email() {
    return this.registerForm.get('email');
  }

  get password() {
    return this.registerForm.get('password');
  }

  get age() {
    return this.registerForm.get('age');
  }

  get role() {
    return this.registerForm.get('role');
  }

  get gender() {
    return this.registerForm.get('gender');
  }

  onSubmit() {
    if (this.registerForm.valid) {
      if (this.registerForm.value.role === 'ROLE_ATHLETE') {
        this.router.navigate(['/signup/athlete'], { queryParams: { ...this.registerForm.value } });
        return;
      }
      const userData = this.registerForm.value;
      this.authService.register(userData).subscribe({
        next: (response) => {
          console.log('Trainer Registration successful', response);
          this.router.navigate(['/login']);
        },
        error: (err) => {
          console.error('Registration failed', err);
        },
      });
    } else {
      console.error('Form is invalid');
    }
  }
}
