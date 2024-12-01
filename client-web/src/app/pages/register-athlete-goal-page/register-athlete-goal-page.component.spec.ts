import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RegisterAthleteGoalPageComponent } from './register-athlete-goal-page.component';

describe('RegisterAthleteGoalPageComponent', () => {
  let component: RegisterAthleteGoalPageComponent;
  let fixture: ComponentFixture<RegisterAthleteGoalPageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RegisterAthleteGoalPageComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RegisterAthleteGoalPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
