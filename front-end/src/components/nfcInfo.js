import React, {useEffect} from 'react';
import {
    makeStyles,
    Table,
    TableBody,
    TableCell,
    TableHead,
    TableRow,
    Paper,
    Toolbar,
    Typography,
    Grid,
    IconButton, Collapse, Box
} from "@material-ui/core";
import KeyboardArrowDownIcon from '@material-ui/icons/KeyboardArrowDown';
import KeyboardArrowUpIcon from '@material-ui/icons/KeyboardArrowUp';

import axios from "axios";
import NavBar from "./NavBar";
import moment from "moment";


const useStyles = makeStyles(theme => ({
    root: {
        //width: '100%',
        paddingLeft: 40,
        paddingRight: 40,
        paddingTop: 20,
        paddingBottom: 40
    },
    paper: {
        marginTop: theme.spacing(1),
        //width: '100%',
        overflowX: 'auto',
        marginBottom: theme.spacing(1),
    },
    table: {
        //width: 330,
    },
    bar: {
        paddingTop: 10,
        paddingBottom: 20
    },
}));

/*
const Cell = ({list, isOpen}) => {

    return (
        <TableCell style={{paddingBottom: 0, paddingTop: 0}} colSpan={6}>
            <Collapse in={isOpen} timeout="auto" unmountOnExit>
                <Box margin={1}>
                    <Typography style={{paddingTop: 10, paddingLeft: 20, color: 'grey'}} variant="h6" gutterBottom component="div">
                        <b>Charging Sessions</b>
                    </Typography>
                    <Table size="small">
                        <TableHead>
                            <TableRow>
                                <TableCell></TableCell>
                                <TableCell><b>Session</b></TableCell>
                                <TableCell><b>Energy Provider</b></TableCell>
                                <TableCell><b>Started on</b></TableCell>
                                <TableCell><b>Finished on</b></TableCell>
                                <TableCell><b>Energy Delivered</b></TableCell>
                                <TableCell><b>Price Policy Ref</b></TableCell>
                                <TableCell><b>Cost/KWh</b></TableCell>
                                <TableCell><b>Cost</b></TableCell>
                                <TableCell><b>Index</b></TableCell>
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {list.map((session, index) => (
                                <TableRow key={session.SessionID}>
                                    <TableCell><b>{index + 1}</b></TableCell>
                                    <TableCell>{session.SessionID}</TableCell>
                                    <TableCell>{session.EnergyProvider}</TableCell>
                                    <TableCell>{session.StartedOn}</TableCell>
                                    <TableCell>{session.FinishedOn}</TableCell>
                                    <TableCell>{session.EnergyDelivered}</TableCell>
                                    <TableCell>{session.PricePolicyRef}</TableCell>
                                    <TableCell>{session.CostPerKWh}</TableCell>
                                    <TableCell>{session.SessionCost}</TableCell>
                                    <TableCell>{session.SessionIndex}</TableCell>
                                </TableRow>
                            ))}
                        </TableBody>
                    </Table>
                </Box>
            </Collapse>
        </TableCell>
    );
}
*/
export default function MoreCustomersInfo() {

    const classes = useStyles();
    const path = window.location.pathname;
    const foo = path.split('/')
    const NFCId = foo[2]

    const [open, setOpen] = React.useState(false);
    const [data, setData] = React.useState(

        [
            {
                NFC_ID: 0,
                firstname: '',
                lastname: '',
                dateofbirth: '',
                number_of_indentification_document: '',
                type_of_indentification_document: '',
                issuing_authority: '',
                phones: '',
                emails: '',
            }
        ]
    );

    useEffect(() => {
        loadData();
    }, [])

    const loadData = async () => {

        const url = 'http://localhost:8765/db/api/customers/' + NFCId ;
        axios.get(url, {
            headers: {
            }
        }).then(response => {
            setData(response.data);
        })
    }

    //const mak = data.phones
    return (
        <div>
            <NavBar/>
            <div className={classes.root}>
                <Paper className={classes.paper} elevation={9}>
                    <Toolbar className={classes.bar}>
                        <Grid container direction="column">
                            <Grid item xs>
                                <Typography variant="h7">NFC ID: <b>{data.NFC_ID}</b></Typography>
                            </Grid>
                            <Grid item xs>
                                <Typography variant="h7">First Name: <b>{data.firstname}</b></Typography>
                            </Grid>
                            <Grid item xs>
                                <Typography variant="h7">Last Name: <b>{data.lastname}</b></Typography>
                            </Grid>
                            <Grid item xs>
                                <Typography variant="h7">Date Birth: <b>{moment(new Date(data.dateofbirth)).format(" D MMM YYYY")}</b></Typography>
                            </Grid>
                            <Grid item xs>
                                <Typography variant="h7">Type of Identification Document: <b>{data.type_of_indentification_document}</b></Typography>
                            </Grid>
                            <Grid item xs>
                                <Typography variant="h7">Number of Identification Document: <b>{data.number_of_indentification_document}</b></Typography>
                            </Grid>
                            <Grid item xs>
                                <Typography variant="h7">Issuing Authority: <b>{data.issuing_authority}</b></Typography>
                            </Grid>
                            <Grid item xs>
                                <Typography variant="h7">Phone(s): <b>{data.phones}</b></Typography>
                            </Grid>
                            <Grid item xs>
                                <Typography variant="h7">Email(s): <b>{data.emails}</b></Typography>
                            </Grid>
                        </Grid>
                    </Toolbar>

                </Paper>
            </div>
        </div>
    )
}