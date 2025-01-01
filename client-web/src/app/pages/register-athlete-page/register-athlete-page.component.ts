import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { AuthService } from '../../services/auth/auth.service';
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

  constructor(private fb: FormBuilder, private authService: AuthService, private router: Router, private route: ActivatedRoute) { }

  ngOnInit() {
    this.registerForm = this.fb.group({
      weight: ['', [Validators.required]],
      height: ['', [Validators.required]],
      goal: ['', [Validators.required]],
    });
  }

  get weight() {
    return this.registerForm.get('weight');
  }

  get height() {
    return this.registerForm.get('height');
  }

  get goal() {
    return this.registerForm.get('goal');
  }

  onSubmit() {
    if (this.registerForm.valid) {
      const formData = { ...this.route.snapshot.queryParams, ...this.registerForm.value };
      console.log(formData);
      this.authService.registerAthlete(formData).subscribe({
        next: (response) => {
          console.log('Athlete Registration successful', response);
          this.router.navigate(['/login']);
        },
        error: (err) => {
          console.error('Registration failed', err);
        }
      });
    }
  }
}
