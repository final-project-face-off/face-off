class AllTeams extends React.Component{
    constructor(props) {
        super(props);
    
        this.state = {
          teams: []
      };

    }  
    componentDidMount() {
      console.log("Component mounted");

      $.getJSON('/api/v1/teams.json', (response) => { this.setState({ teams: response }) });
    };
  
    render() {
        var teams= this.state.teams.map((team) => {
            return (
                <div key={team.id}>
                    <h3>{team.name}</h3>
                    <p>Wins: {team.wins}</p>
                    <p>Losses: {team.losses}</p>
                </div>
            )
        });
    
        return(
            <div>
                {teams}
            </div>
        )
    }
    
  };
  