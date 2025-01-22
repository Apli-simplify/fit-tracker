import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule, FormControl } from '@angular/forms';
import { MatTableDataSource, MatTableModule } from '@angular/material/table';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatSelectModule } from '@angular/material/select';
import { CommonModule } from '@angular/common';
import { AdminService } from '../../services/admin/admin.service'; // Import the service
import { MatDialog } from '@angular/material/dialog';
import { ExerciseDialogComponent } from '../../components/exercise-dialog/exercise-dialog.component';
import { ProgramDialogComponent } from '../../components/program-dialog/program-dialog.component';

@Component({
  selector: 'app-admin-page',
  templateUrl: './admin-page.component.html',
  styleUrls: ['./admin-page.component.scss'],
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatCardModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatTableModule,
    MatSelectModule,
  ],
})
export class AdminPageComponent implements OnInit {
  exercises: any[] = [];
  programs: any[] = [];
  users: any[] = [];

  exerciseColumns: string[] = ['name', 'targetArea', 'difficulty', 'description', 'duration', 'videoUrl'];
  programColumns: string[] = ['name', 'image', 'time', 'exercises'];
  userColumns: string[] = ['id', 'name', 'email', 'gender', 'age', 'role'];

  exerciseDataSource = new MatTableDataSource<any>(this.exercises);
  programDataSource = new MatTableDataSource<any>(this.programs);
  userDataSource = new MatTableDataSource<any>(this.users);

  constructor(
    private dialog: MatDialog,
    private adminService: AdminService
  ) { }

  ngOnInit(): void {
    this.fetchUsers();
    this.fetchPrograms();
    this.fetchExercises();
  }

  fetchUsers() {
    this.adminService.getAllUsers().subscribe({
      next: (data: any) => {
        this.users = data;
        this.userDataSource.data = this.users;
      },
      error: (error) => {
        console.error('Error fetching users:', error);
      },
    });
  }

  fetchPrograms() {
    this.adminService.getAllPrograms().subscribe({
      next: (data: any) => {
        this.programs = data;
        this.programDataSource.data = this.programs;
      },
      error: (error) => {
        console.error('Error fetching programs:', error);
      },
    });
  }

  fetchExercises() {
    this.adminService.getAllExercises().subscribe({
      next: (data: any) => {
        this.exercises = data;
        this.exerciseDataSource.data = this.exercises;
      },
      error: (error) => {
        console.error('Error fetching exercises:', error);
      },
    });
  }

  openExerciseDialog(): void {
    const dialogRef = this.dialog.open(ExerciseDialogComponent, {
      width: '500px',
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.adminService.addExercise(result).subscribe({
          next: (response) => {
            this.exercises.push(response);
            this.exerciseDataSource.data = this.exercises;
          },
          error: (error) => {
            console.error('Error adding exercise:', error);
          },
        });
      }
    });
  }

  openProgramDialog(): void {
    const dialogRef = this.dialog.open(ProgramDialogComponent, {
      width: '500px',
      data: { exercises: this.exercises }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.adminService.addProgram(result).subscribe({
          next: (response) => {
            this.programs.push(response);
            this.programDataSource.data = this.programs;
          },
          error: (error) => {
            console.error('Error adding program:', error);
          },
        });
      }
    });
  }
}