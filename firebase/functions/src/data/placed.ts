export interface Match {
  bo: number
  view_count: number
  league_id: string
  share_count: number
  like_count: number
  team2: string
  team1: string
  schedule: Schedule
  matchStreamUrl: string
  totals: Total[]
  placed: Placed[]
  category_id: string
}

export interface Schedule {
  _seconds: number
  _nanoseconds: number
}

export interface Total {
  placed_total_cof: number
  placed_total_sum: number
  on_team_id: string
}

export interface Placed {
  userId: string
  place: number
  onTeamId: string
}