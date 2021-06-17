import React from 'react';
import NavBar from "./NavBar";
import DateFnsUtils from '@date-io/date-fns';
//import FormControl from '@material-ui/core/FormControl';
import MenuItem from '@material-ui/core/MenuItem';
import Select from '@material-ui/core/Select';
import {
    makeStyles,
    FormControl,
    InputLabel,
    Input,
    Box,
    Button,
    Paper
} from "@material-ui/core";
import {
    MuiPickersUtilsProvider,
    KeyboardDatePicker,
} from '@material-ui/pickers';
import {useHistory} from "react-router-dom";

const useStyles = makeStyles((theme) => ({
    root: {
        //flexGrow: 1
    },
    containerC: {
        paddingLeft: 80,
        paddingRight: 80,
        //width: '80%',
        paddingTop: 40
    },
    containerN: {
        paddingLeft: 80,
        paddingRight: 80,
        //width: '80%',
        paddingTop: 0
    },
    header: {
        paddingLeft: 35,
        paddingTop: 10
        //margin: 10
    },
    boxButton: {
        paddingLeft: theme.spacing(4)
    },
    formControl: {
        margin: theme.spacing(2),
        minWidth: 120,
    },
    button: {
        textTransform: 'none'
    }
}));

function convertDate(date) {
    const month = ("0" + (date.getMonth() + 1)).slice(-2);
    const day = ("0" + date.getDate()).slice(-2);
    return [date.getFullYear(), month, day].join("");
}

export default function Visits() {

    //const [service, setService] = React.useState('');

    //const handleChange = (event) => {
    //    setService(event.target.value);
    const classes = useStyles();
    const history = useHistory();

    /***************************************************************************************
     * Covid Check
     ***************************************************************************************/

    const [id, setId] = React.useState(null);
    const handleId = event => {
        setId(event.target.value);
    }
    const idSubmitHandler = event => {
        event.preventDefault();
        history.push(`/find_exposed_areas/` + id );
    }


    return (


        <div className={classes.root}>
            <NavBar/>

            <div className={classes.containerC}>
                <Paper elevation={6} className={classes.paper}>
                    <div className={classes.header}>
                        <h3>Insert the Customer ID Patient</h3>
                    </div>
                    <form autoComplete="off" onSubmit={idSubmitHandler}>

                        <Box display="flex" flexDirection="row" p={2} m={2} bgcolor="background.paper">

                            <Box p={2}>
                                <FormControl margin="normal" fullWidth>
                                    <InputLabel htmlFor="providerId" shrink={true}>ID</InputLabel>
                                    <Input required={false} id="providerId" type="number"
                                           value={id}
                                           onChange={e => handleId(e)}/>
                                </FormControl>
                            </Box>

                            <Box className={classes.boxButton} p={1} m={1}>
                                <Button className={classes.button} variant="contained" color="primary" type="submit"
                                        onSubmit={idSubmitHandler}>
                                    Search
                                </Button>
                            </Box>
                        </Box>
                    </form>
                </Paper>
            </div>



        </div>

    )
        ;
}