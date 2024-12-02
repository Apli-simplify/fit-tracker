import { Routes } from '@angular/router';
import { HomePageComponent } from './pages/home-page/home-page.component';
import { LoginPageComponent } from './pages/login-page/login-page.component';
import { RegisterPageComponent } from './pages/register-page/register-page.component';
import { RegisterAthletePageComponent } from './pages/register-athlete-page/register-athlete-page.component';
import { RegisterAthleteGoalPageComponent } from './pages/register-athlete-goal-page/register-athlete-goal-page.component';

export const routes: Routes = [
    { path: '', component: HomePageComponent, title: 'Home Page' },
    { path: 'signup', component: RegisterPageComponent, title: 'Register Page' },
    { path: 'login', component: LoginPageComponent, title: 'Login Page' },
    { path: 'signup/athlete', component: RegisterAthletePageComponent },
    { path: 'signup/athlete/goal', component: RegisterAthleteGoalPageComponent },
    { path: '**', redirectTo: '', pathMatch: 'full' },
];
