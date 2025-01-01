import { Routes } from '@angular/router';
import { roleGuard } from './guards/role/role.guard';
import { HomePageComponent } from './pages/home-page/home-page.component';
import { LoginPageComponent } from './pages/login-page/login-page.component';
import { RegisterPageComponent } from './pages/register-page/register-page.component';
import { RegisterAthletePageComponent } from './pages/register-athlete-page/register-athlete-page.component';
import { AdminPageComponent } from './pages/admin-page/admin-page.component';
import { TrainerPageComponent } from './pages/trainer-page/trainer-page.component';
import { AthletePageComponent } from './pages/athlete-page/athlete-page.component';

export const routes: Routes = [
    { path: 'home', component: HomePageComponent, title: 'Home Page' },
    { path: 'signup', component: RegisterPageComponent, title: 'Register Page' },
    { path: 'login', component: LoginPageComponent, title: 'Login Page' },
    { path: 'signup/athlete', component: RegisterAthletePageComponent },
    { path: 'admin', component: AdminPageComponent, canActivate: [roleGuard], data: { roles: ['ROLE_ADMIN'] } },
    { path: 'athlete', component: AthletePageComponent, canActivate: [roleGuard], data: { roles: ['ROLE_ATHLETE'] } },
    { path: 'trainer', component: TrainerPageComponent, canActivate: [roleGuard], data: { roles: ['ROLE_TRAINER'] } },
    { path: '**', redirectTo: 'home', pathMatch: 'full' },
];
